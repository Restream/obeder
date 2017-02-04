<template>
  <div class="user-select">
    User Select
    <button v-for="user in users" v-on:click="makeAuth(user.id)">{{user.name}}</button>
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
</style>
