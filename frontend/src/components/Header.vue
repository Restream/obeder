<template>
  <div class="header">
    <div class="header__logo">
      <img class="logo" src="../assets/images/logo.svg">
      <img class="logo_obeder" src="../assets/images/obeder.svg">
    </div>

    <div class="header__switcher">
      <span class="header__switcher-label">Не ем</span>
      <label class="label">
        <input type="checkbox" v-model="neem">
        <span class="circle"></span>
      </label>
      <span class="header__switcher-label">Eм</span>
    </div>
  </div>
</template>

<script>
  export default {
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

  .header__switcher {
    display: flex;
    align-items: center;
  }

  .header__switcher-label {
    font-weight: 400;
    font-size: 20px;
    color: #4D4D4D;
    letter-spacing: 0.01px;
    display: inline-block;
    margin: 0 14px;
  }

  .label {
    display: flex;
    align-items: center;
    cursor: pointer;
    height: 26px;

    & input {
      display: none;
    }

    & input:checked {
      & + .circle {
        &::after {
          transform: translateX(24px);
          background: #38B5C7;
          border: none;
        }
      }
    }
  }

  .circle {
    background: rgba(0,0,0,0.30);
    height: 2px;
    width: 50px;
    position: relative;
    top: 2px;
    display: inline-block;
    font-size: 0;

    &::after {
      content: '';
      display: block;
      width: 26px;
      height: 26px;
      position: absolute;
      left: 0;
      top: -13px;
      background-color: #fff;
      border: 2px solid #4a4a4a;
      border-radius: 50%;
      transition: transform 300ms ease-in-out;
      box-sizing: border-box;
    }
  }

  @media (--desktop) {
    .header__logo {
      display: flex;
    }
  }
</style>
