<template>
  <div class="header">
    <div class="header__logo">
      <img class="logo" src="../assets/images/logo.svg">
      <img class="logo_obeder" src="../assets/images/obeder.svg">
    </div>

    <div class="header__switcher">
      <span class="header__switcher-label">Не ем</span>
      <switches v-model="neem" :selected="neem" color="blue"></switches>
      <span class="header__switcher-label">Ем</span>
    </div>
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

  .header__logo {
    position: absolute;
    height: 36px;
    left: 10px;
    top: 10px;
    display: flex;
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

  .header__switcher-label {
    font-weight: 400;
    font-size: 20px;
    color: #4D4D4D;
    letter-spacing: 0.01px;
    display: inline-block;
    margin: 0 14px;
  }

  @media (--desktop) {
    .header__logo {
      display: flex;
    }
  }
</style>
