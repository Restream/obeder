import urljoin from 'url-join';

import { baseUrl, request, apiClientFactory } from './apiClient';

const url = urljoin(baseUrl, 'users');
const apiWrapper = apiClientFactory(url);

apiWrapper.getMenus = id => request(urljoin(url, id, 'menus'), 'GET');

export default apiWrapper;
