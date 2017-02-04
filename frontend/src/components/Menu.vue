<template>
  <div class="menu">
    <menu-header></menu-header>
    <daily-menu v-for="date in dates" :day="date"></daily-menu>
  </div>
</template>

<script>
  import usersService from 'api/users';

  import Header from './Header';
  import DailyMenu from './Menu/DailyMenu';

  export default {
    components: {
      'menu-header': Header,
      'daily-menu': DailyMenu,
    },
    created() {
      const id = localStorage.getItem('user_uid');

      usersService
        .getMenus(id)
        .then(
          (menuDates) => {
            this.dates = menuDates;
          },
          error => error,
        );
    },
    name: 'menu',
    data() {
      return {
        dates: [],
      };
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
