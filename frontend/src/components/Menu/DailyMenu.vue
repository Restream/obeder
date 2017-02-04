<template>
  <div class="daily-menu">
    <h1>{{date}}</h1>
    <menu-dish :date="date" v-for="(dishes, type) in dishTypes" :dishes="dishes" :type="type"></menu-dish>
    <button v-on:click="setToDefault">Сбросить в дефолт</button>
  </div>
</template>

<script>
  import _ from 'lodash';
  import MenuDish from './MenuDish';

  export default {
    components: {
      'menu-dish': MenuDish,
    },
    name: 'DailyMenu',
    props: {
      day: Object,
    },
    data() {
      const types = {};

      this.day.dishes.forEach((dish) => {
        if (!types[dish.dishType]) {
          types[dish.dishType] = [];
        }

        types[dish.dishType].push(dish);
      });

      return {
        date: this.day.date,
        dishTypes: types,
      };
    },
    methods: {
      setToDefault() {
        const defaultDishes = {};

        _.each(this.dishTypes, (dishes, type) => {
          defaultDishes[type] = dishes.map(dish => ({
            ...dish,
            selected: dish.default,
          }));
        });
        this.dishTypes = defaultDishes;
      },
    },
  };
</script>

<style scoped>
</style>
