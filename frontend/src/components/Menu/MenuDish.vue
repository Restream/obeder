<template>
  <div class="menu-dish">
    {{type}}
    <ul>
      <li v-for="dish in dishes">
        <input type="radio" :name="radioIdentifier" :value="dish.id" v-model="selectedDish">
        {{dish.name}}
      </li>
    </ul>
  </div>
</template>

<script>
  import _ from 'lodash';

  function getSelectedDishId(dishes) {
    const selectedDish = _.find(dishes, { selected: true })
      || _.find(dishes, { default: true });

    return selectedDish && selectedDish.id;
  }

  export default {
    name: 'MenuDish',
    props: {
      date: String,
      dishes: Array,
      type: String,
    },

    watch: {
      dishes(newDishes) {
        this.selectedDish = getSelectedDishId(newDishes);
      },
    },

    data() {
      return {
        radioIdentifier: this.date + this.type,
        selectedDish: getSelectedDishId(this.dishes),
      };
    },
  };
</script>

<style scoped>
</style>
