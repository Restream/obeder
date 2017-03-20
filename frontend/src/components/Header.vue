<template>
  <div class="header">
    <div class="header__logo">
      <img class="logo" src="../assets/images/logo.svg">
      <img class="logo_obeder" src="../assets/images/obeder.svg">
    </div>

    <div class="header__user">{{user.name}}</div>
  </div>
</template>

<script>
  import usersService from 'api/users';

  export default {
    name: 'Header',
    created() {
      const id = localStorage.getItem('user_uid');

      usersService
        .getOne(id)
        .then(
          (user) => {
            this.user = {
              ...user,
              em: !user.neem,
            };
          },
          error => error,
        );
    },
    data() {
      return {
        user: {},
      };
    },
    methods: {
      onChange(em) {
        const id = localStorage.getItem('user_uid');
        const payload = {
          user: {
            neem: !em,
          },
        };

        usersService.save(id, payload);
      },
    },
  };
</script>

<style scoped>
  @import "../assets/styles/variables.css";

  .header {
    background: #FFFFFF;
    box-shadow: 0 2px 5px 0 rgba(0,0,0,0.26);
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
    color: #4D4D4D;
  }

  .header__logo {
    position: absolute;
    height: 36px;
    left: 10px;
    align-items: center;
    display: none;
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
</style>
