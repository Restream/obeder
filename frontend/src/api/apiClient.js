import queryString from 'query-string';
import urljoin from 'url-join';
import humps from 'humps';

export const baseUrl = '/api';

export function request(url, method, urlParams = false, body = false) {
  let urlParamsPart = '';
  if (urlParams) {
    const urlParamsAsString = queryString.stringify(urlParams);
    urlParamsPart = `?${urlParamsAsString}`;
  }
  const options = { method };
  if (body) {
    const jsonWraper = humps.decamelizeKeys(body);
    const headers = new Headers({
      'Content-Type': 'application/json',
    });

    options.body = JSON.stringify(jsonWraper);
    options.headers = headers;
    options.credentials = 'same-origin';
  }
  return fetch(`${url}${urlParamsPart}`, options)
    .then(response => response.text())
    .then(text => text && JSON.parse(text))
    .then(json => humps.camelizeKeys(json));
}

export function apiClientFactory(url) {
  return {
    get(page, pageSize) {
      return request(url, 'GET',
        {
          page,
          page_size: pageSize,
        },
      );
    },
    getOne(id) {
      return request(urljoin(url, id), 'GET');
    },
    create(fields) {
      return request(url, 'POST', false, fields);
    },
    remove(id) {
      return request(urljoin(url, id), 'DELETE');
    },
    save(id, fields) {
      return request(urljoin(url, id), 'PUT', false, fields);
    },
  };
}

