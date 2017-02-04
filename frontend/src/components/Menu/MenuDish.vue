<template>
  <div class="menu-dish">
    {{type}}
    <ul>
      <li v-for="dish in dishes">
        <input type="radio" :name="radioIdentifier" :value="dish.name" v-model="selectedDish">
        {{dish.name}}
      </li>
    </ul>
  </div>
</template>

<script>
  import _ from 'lodash';

  export default {
    name: 'MenuDish',
    props: {
      date: String,
      dishes: Array,
      type: String,
    },
    data() {
      const selectedDish = _.find(this.dishes, { selected: true })
        || _.find(this.dishes, { default: true });

      return {
        radioIdentifier: this.date + this.type,
        selectedDish: selectedDish && selectedDish.name,
      };
    },
  };
</script>

<style scoped>
</style>
