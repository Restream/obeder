import urljoin from 'url-join';

import { baseUrl, request, apiClientFactory } from './apiClient';

const url = urljoin(baseUrl, 'users');
const apiWrapper = apiClientFactory(url);

apiWrapper.getMenus = id => request(urljoin(url, id, 'menus'), 'GET');
apiWrapper.setMenu = (userId, id, dishes, description) => {
  const menuUrl = urljoin(baseUrl, 'user_menus', id);

  const payload = {
    user_menu: { dishes, description },
  };

  return request(menuUrl, 'PUT', false, payload);
};

export default apiWrapper;
