<template>
  <div class="menu">
    <menu-header @onDisableMenuSwitchers="disableMenuSwitchers"/>
    <div v-if="!menusLoaded" class="preloader"></div>
    <div class="content">
      <daily-menu v-for="date in sortedDates" :day="date" :isSwitchDisabled="headerSwitchIsDisabled" />
      <div v-if="menusLoaded && sortedDates.length === 0" class="bs-callout">
        <h4 class="title">К сожалению, меню еще не заполнено</h4>
      </div>
    </div>
  </div>
</template>

<script>
  import _ from 'lodash';
  import usersService from 'api/users';

  import Header from './Header';
  import DailyMenu from './Menu/DailyMenu';

  export default {
    components: {
      'menu-header': Header,
      'daily-menu': DailyMenu,
    },
    created() {
      usersService
        .getMenus()
        .then(
          (menuDates) => {
            this.menusLoaded = true;
            this.dates = menuDates;
          },
          error => error,
        );
    },
    name: 'menu',
    data() {
      return {
        dates: [],
        headerSwitchIsDisabled: false,
        menusLoaded: false,
      };
    },
    computed: {
      sortedDates() {
        return _.sortBy(this.dates, ['date']);
      },
    },
    methods: {
      disableMenuSwitchers(val) {
        this.headerSwitchIsDisabled = val;
      },
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import "../assets/styles/variables.css";

.content {
  max-width: var(--desktop-width);
  padding: 15px;
  margin: 0 auto;
}

@media (--desktop) {
  .content {
    padding: 30px 0;
  }
}

.bs-callout {
  padding: 20px;
  margin: 20px 0;
  border: 1px solid #eee;
  border-left: 5px solid #1b809e;
  border-radius: 3px;
}

.title {
  margin: 0 0 5px;
  color: #1b809e;
}

.preloader {
  margin: 120px auto 0;
  border: 16px solid #f3f3f3;
  border-top: 16px solid #3498db;
  border-radius: 50%;
  width: 120px;
  height: 120px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
