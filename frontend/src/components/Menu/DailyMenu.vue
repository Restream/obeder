<template>
  <div class="daily-menu">
    <h1 class="date">{{date}}</h1>
    <div class="daily-menu__list">
      <menu-dish :date="date" v-for="(dishes, type) in dishTypes" :dishes="dishes" :type="type"></menu-dish>
      <button v-on:click="setToDefault">Сбросить в дефолт</button>
    </div>
  </div>
</template>

<script>
  import _ from 'lodash';
  import MenuDish from './MenuDish';
  import MenuPresenter from '../../presenters/MenuPresenter';

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
        date: MenuPresenter.date(this.day.date),
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
@import "../../assets/styles/variables.css";

.daily-menu {
  margin-bottom: 53px;
}

.date {
  font-weight: normal;
  font-size: 24px;
  color: #000000;
  letter-spacing: 0.01px;
  margin-bottom: 20px;

  &:first-letter {
    text-transform: uppercase;
  }
}

.daily-menu__list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

@media (--desktop) {
  .daily-menu {
    margin-bottom: 80px;
  }

  .date {
    font-size: 36px;
    letter-spacing: 0.02px;
    margin-bottom: 30px;
  }
}
</style>
