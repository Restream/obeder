import urljoin from 'url-join';

import { baseUrl, request, apiClientFactory } from './apiClient';

const url = urljoin(baseUrl, 'user');
const apiWrapper = apiClientFactory(url);

apiWrapper.getUser = () => apiWrapper.getOne(null);
apiWrapper.saveUser = fields => apiWrapper.save(null, fields);

apiWrapper.getMenus = () => request(urljoin(url, 'menus'), 'GET');
apiWrapper.setMenu = (id, { dishes, description, neem }) => {
  const menuUrl = urljoin(baseUrl, 'user_menus', id);
  const payload = {
    user_menu: { dishes, description, neem },
  };

  return request(menuUrl, 'PUT', false, payload);
};
apiWrapper.setVote = (id, { dish_id, voted }) => {
  const menuUrl = urljoin(baseUrl, 'user_menu_votes', id);
  const payload = {
    user_menu_vote: { dish_id, voted },
  };

  return request(menuUrl, 'PUT', false, payload);
};

export default apiWrapper;
