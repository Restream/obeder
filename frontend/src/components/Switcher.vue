<template>
  <div class="switcher">
    <span class="switcher-label">Не ем</span>
    <label class="label" v-bind:class="{ disable: this.isDisabled }">
      <input type="checkbox" v-model="active" @click="onChange(active)">
      <span class="circle"></span>
    </label>
    <span class="switcher-label">Ем</span>
  </div>
</template>

<script>
export default {
  name: 'Switcher',
  props: {
    isDisabled: {
      type: Boolean,
      default: false,
    },
    isOn: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      active: this.isOn,
    };
  },
  watch: {
    isOn(newVal) {
      this.active = newVal;
    },
  },
  methods: {
    onChange(value) {
      this.$emit('onToggle', value);
    },
  },
};
</script>

<style scoped>
@import "../assets/styles/variables.css";

.switcher {
  display: flex;
  align-items: center;
}

.switcher-label {
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

.disable {
  pointer-events: none;
  opacity: 0.3
}
</style>
