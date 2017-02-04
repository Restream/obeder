import Vue from 'vue';
import Router from 'vue-router';

import Hello from 'components/Hello';
import UserSelect from 'components/UserSelect';
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
      name: 'Hello',
      component: Hello,
      redirect: '/menu',
    },
    {
      path: '/menu',
      name: 'Menu',
      component: Menu,
      beforeEnter: (to, from, next) => {
        if (!getUid()) {
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
      beforeEnter: (to, from, next) => {
        if (getUid()) {
          next('/menu');
        } else {
          next();
        }
      },
    },
  ],
});
