<template>
  <div class="header">
    <img class="headerLogo" src="../assets/logo.svg">
    <span>Не ем</span>
    <switches v-model="neem" :selected="neem"></switches>
    <span>Ем</span>
  </div>
</template>

<script>
  import Switches from 'vue-switches';

  export default {
    components: {
      switches: Switches,
    },
    name: 'Header',
    data() {
      return {
        neem: false,
      };
    },
  };
</script>

<style scoped>
</style>
