<template>
  <div class="daily-menu">
    <h1 class="date">{{date}}</h1>
    <div class="daily-menu__list">
      <menu-dish
        :date="date"
        v-for="(dishes, type) in dishTypes"
        :dishes="dishes"
        :type="type"
        :onChange="onDishChange"
      >
      </menu-dish>
      <div class="daily-menu__actions">
        <div class="daily-menu__comment">
          <textarea class="daily-menu__textarea" v-model="day.description" placeholder="Комментарий" v-on:keyup="sendComment"></textarea>
        </div>
        <button v-on:click="setToDefault" class="button">Сбросить в дефолт</button>
      </div>
    </div>
  </div>
</template>

<script>
  import _ from 'lodash';

  import usersService from 'api/users';
  import MenuDish from './MenuDish';
  import MenuPresenter from '../../presenters/MenuPresenter';

  const userId = localStorage.getItem('user_uid');

  function getSelectedDishes(dishTypes) {
    return _.reduce(dishTypes, (acc, dishes) => {
      const selectedDish = _.find(dishes, { selected: true }) || dishes[0];

      return [
        ...acc,
        { id: selectedDish.id },
      ];
    }, []);
  }

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

      onDishChange(type, dishId) {
        const dishes = this.dishTypes[type];
        const updatedDishes = dishes.map(dish => ({
          ...dish,
          selected: dish.id === dishId,
        }));

        this.dishTypes = {
          ...this.dishTypes,
          [type]: updatedDishes,
        };

        usersService
          .setMenu(userId, this.day.id, getSelectedDishes(this.dishTypes));
      },

      sendComment(event) {
        usersService
          .setMenu(userId, this.day.id, getSelectedDishes(this.dishTypes), event.target.value);
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

.button {
  background: #38B5C7;
  border-radius: 4px;
  font-family: Roboto;
  font-size: 20px;
  color: #FFFFFF;
  border: none;
  cursor: pointer;
  height: 40px;

  &:hover {
    opacity: 0.9;
  }
}

.daily-menu__actions {
  width: 100%;
  display: flex;
  flex-direction: column;
  margin-bottom: 28px;
}

.daily-menu__comment {
  flex: 1;
  min-height: 60px;
  margin-bottom: 10px;
}

.daily-menu__textarea {
  height: 100%;
  width: 100%;
  resize: none;
  border: 1px solid #ccc;
  padding: 10px;
  font-size: 16px;
  border-radius: 3px;
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

  .daily-menu__actions {
    width: calc(50% - 14px);
  }
}
</style>
