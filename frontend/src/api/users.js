import urljoin from 'url-join';

import { baseUrl, apiClientFactory } from './apiClient';

const url = urljoin(baseUrl, 'users');
const apiWrapper = apiClientFactory(url);

export default apiWrapper;
