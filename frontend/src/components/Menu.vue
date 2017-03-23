<template>
  <div class="menu">
    <menu-header @onDisableMenuSwitchers="disableMenuSwitchers"/>
    <div class="content">
      <daily-menu v-for="date in sortedDates" :day="date" :isSwitchDisabled="headerSwitchIsDisabled" />
      <div v-if="sortedDates.length === 0" class="bs-callout">
        <h4>К сожалению, меню еще не заполнено</h4>
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
        headerSwitchIsDisabled: false,
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
  border-left-width: 5px;
  border-radius: 3px;
  border-left-color: #1b809e !important;
}
.bs-callout h4 {
  color: #1b809e;
  font-size: 18px;
  margin: 0 0 5px;
}
</style>
