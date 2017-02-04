<template>
  <div class="user-select">
    <div class="content">
      <img src="../assets/images/logo.svg" class="logo">
      <img src="../assets/images/obeder.svg" class="obeder">
      <h1 class="title">Представься, пёс</h1>
      <div class="buttons">
        <button v-for="user in users" v-on:click="makeAuth(user.id)" class="button">
          {{user.name}}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
  import userService from 'api/users';

  export default {
    name: 'userSelect',
    created() {
      userService
        .get()
        .then(
          (items) => {
            this.users = items;
          },
          error => error,
        );
    },
    data() {
      return {
        users: [],
      };
    },
    methods: {
      makeAuth(id) {
        localStorage.setItem('user_uid', id);
        this.$router.replace('/menu');
      },
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .user-select {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .content {
    max-width: 480px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    padding: 40px 20px;
  }

  .logo {
    margin-bottom: 14px;
  }

  .obeder {
    margin-bottom: 40px;
  }

  .title {
    margin-bottom: 20px;
    font-size: 32px;
    font-weight: bold;
  }

  .buttons {
    display: flex;
    flex-direction: column;
  }

  .button {
    margin-bottom: 10px;
    background: #38B5C7;
    border-radius: 4px;
    font-family: Roboto;
    font-size: 20px;
    color: #FFFFFF;
    border: none;
    cursor: pointer;
    height: 40px;

    &:hover {
      opacity: 0.9;
    }
  }
</style>
