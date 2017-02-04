import Vue from 'vue';
import Router from 'vue-router';

import Hello from 'components/Hello';
import UserSelect from 'components/UserSelect';
import Menu from 'components/Menu';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Hello',
      component: Hello,
    },
    {
      path: '/menu',
      name: 'Menu',
      component: Menu,
      beforeEnter: (to, from, next) => {
        const uid = localStorage.getItem('user_uid');
        if (!uid) {
          next('/user-select');
        } else {
          next();
        }
      },
    },
    {
      path: '/user-select',
      name: 'UserSelect',
      component: UserSelect,
    },
  ],
});
