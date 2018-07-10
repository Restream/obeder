<template>
  <div class="header">
    <div class="header__logo">
      <img class="logo" src="../assets/images/logo.svg">
      <img class="logo_obeder" src="../assets/images/obeder.svg">
    </div>

    <header-switcher :isOn='isSwitchOn' @onToggle="headerSwitchToggle" />

    <div class="header__user">
      {{user.name}}
      <router-link class='logout_icon' to='/logout' v-hint.left.rounded='`Выйти`'>
        <i class='fa fa-sign-out fa-lg' aria-hidden='true'></i>
      </router-link>
    </div>
  </div>
</template>

<script>
import Hint from "vue-hint.css";
import usersService from "api/users";
import Switcher from "./Switcher";

export default {
  components: {
    "header-switcher": Switcher
  },
  directives: {
    Hint
  },
  name: "Header",
  created() {
    usersService.getUser().then(user => {
      this.user = {
        ...user,
        em: !user.neem
      };
      this.isSwitchOn = this.user.em;
      this.$emit("onDisableMenuSwitchers", !this.isSwitchOn);
    }, error => error);
  },
  mounted() {
    this.$emit("onDisableMenuSwitchers", !this.isSwitchOn);
  },
  data() {
    return {
      user: {},
      isSwitchOn: false
    };
  },
  methods: {
    headerSwitchToggle(value) {
      const payload = {
        user: {
          neem: !value
        }
      };
      usersService.saveUser(payload);
      this.isSwitchOn = value;
      this.user.em = value;
      this.$emit("onDisableMenuSwitchers", !value);
    }
  }
};
</script>

<style scoped>
@import "../assets/styles/variables.css";

.header {
  background: #ffffff;
  box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.26);
  position: relative;
  height: 56px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.header__user {
  position: absolute;
  right: 10px;
  font-weight: 400;
  font-size: 20px;
  color: #4d4d4d;
}

.header__logo {
  position: absolute;
  height: 36px;
  left: 10px;
  align-items: center;
  display: none;
}

.logout_icon {
  color: inherit;
  text-decoration: none;
}

.logo {
  height: 36px;
  margin-right: 10px;
}

.logo_obeder {
  height: 24px;
}

@media (--desktop) {
  .header__logo {
    display: flex;
  }
}

@media (--tablet) {
  .header {
    justify-content: flex-start;
    align-items: center;
    justify-content: space-between;
    overflow: scroll;
    -webkit-overflow-scrolling: touch;
  }

  .header__user {
    position: static;
    white-space: nowrap;
    text-align: right;
  }
}
</style>
