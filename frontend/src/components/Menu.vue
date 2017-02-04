<template>
  <div class="menu">
    <menu-header></menu-header>
  </div>
</template>

<script>
  import Header from './Header';

  export default {
    components: {
      'menu-header': Header,
    },
    name: 'menu',
    data() {
      return {
      };
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
