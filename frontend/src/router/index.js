import Vue from 'vue';
import Router from 'vue-router';

import Menu from 'components/Menu';

Vue.use(Router);

function getUid() {
  return localStorage.getItem('user_uid');
}

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Menu',
      component: Menu,
      beforeEnter: (to, from, next) => {
        if (!getUid()) {
          next('/login');
        } else {
          next();
        }
      },
    },
  ],
});
