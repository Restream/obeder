<template>
  <div class="daily-menu" v-bind:class="{ disable: !this.day.editable }">
    <h1 class="date">
      <span>{{date}}</span>
      <menu-switcher :isDisabled='isSwitchDisabled' :isOn='isSwitchOn' @onToggle="menuSwitchToggle" />
      <a v-on:click="setToDefault" class="default_link">Сбросить</a>
    </h1>

    <div v-if="errors.length > 0" class="daily-menu__errors">
      <ul>
        <li v-for="error in errors">
          {{error}}
        </li>
      </ul>
    </div>

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
          <textarea class="daily-menu__textarea" v-model="day.description" placeholder="Комментарий" v-on:keyup="onChangeComment"></textarea>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import _ from 'lodash';

  import dishTypesDictionary from 'contants/dishTypes';
  import usersService from 'api/users';
  import MenuDish from './MenuDish';
  import MenuPresenter from '../../presenters/MenuPresenter';
  import Switcher from '../Switcher';

  const COMMENT_SEND_TIMEOUT = 350;
  const MENU_SAVE_ERROR = 'При сохранении меню возникла ошибка. Попробуйте обновить страницу.';

  let lastState;

  function getSelectedDishes(dishTypes) {
    return _.reduce(dishTypes, (acc, dishes) => {
      const selectedDish = _.find(dishes, { selected: true });

      return [
        ...acc,
        { id: selectedDish && selectedDish.id },
      ];
    }, []);
  }

  function deselectDishes(dishes) {
    return dishes && dishes.map(dish => ({
      ...dish,
      selected: false,
    }));
  }

  export default {
    components: {
      'menu-dish': MenuDish,
      'menu-switcher': Switcher,
    },
    name: 'DailyMenu',
    props: {
      day: Object,
      isSwitchDisabled: Boolean,
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
        isSwitchOn: !this.day.neem,
        errors: [],
      };
    },
    created() {
      this.sendComment = _.debounce(this.sendData, COMMENT_SEND_TIMEOUT);
    },
    methods: {
      sendData() {
        const currentState = {
          dishes: getSelectedDishes(this.dishTypes),
          description: this.day.description,
          neem: this.day.neem,
        };

        if (_.isEqual(lastState, currentState)) return;

        lastState = currentState;
        usersService
          .setMenu(this.day.id, currentState)
          .catch(() => {
            this.errors.push(MENU_SAVE_ERROR);
          });
      },

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
        if (!dishId) {
          this.dishTypes = {
            ...this.dishTypes,
            [type]: deselectDishes(this.dishTypes[type]),
          };
          return;
        }

        const dishUpdates = {};

        switch (type) {
          case dishTypesDictionary.separate_dish: {
            const mainDishes = deselectDishes(this.dishTypes[dishTypesDictionary.main_dish]);
            const sideDishes = deselectDishes(this.dishTypes[dishTypesDictionary.side_dish]);

            if (mainDishes) {
              dishUpdates[dishTypesDictionary.main_dish] = mainDishes;
            }
            if (sideDishes) {
              dishUpdates[dishTypesDictionary.side_dish] = sideDishes;
            }
            break;
          }
          case dishTypesDictionary.main_dish:
          case dishTypesDictionary.side_dish: {
            if (!this.dishTypes[dishTypesDictionary.separate_dish]) {
              break;
            }

            const separateDishes = deselectDishes(this.dishTypes[dishTypesDictionary.separate_dish]);

            if (separateDishes) {
              dishUpdates[dishTypesDictionary.separate_dish] = separateDishes;
            }
            break;
          }
          default: {
            break;
          }
        }
        const dishes = this.dishTypes[type];
        const updatedDishes = dishes.map(dish => ({
          ...dish,
          selected: dish.id === dishId,
        }));

        this.dishTypes = {
          ...this.dishTypes,
          ...dishUpdates,
          [type]: updatedDishes,
        };

        this.sendData();
      },

      onChangeComment(event) {
        this.day.description = event.target.value;
        this.sendComment();
      },

      menuSwitchToggle(value) {
        this.day.neem = !value;
        this.sendData();
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
  display: flex;
  justify-content: space-between;
  align-items: baseline;

  &:first-letter {
    text-transform: uppercase;
  }
}

.daily-menu__list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.default_link {
  font-size: 18px;
  cursor: pointer;
  text-decoration: none;
  color: #666;
  border-bottom: 1px dashed;

  &:hover {
    color: #333;
    transition: color 300ms ease-in-out;
  }
}

.daily-menu__errors {
  padding: 20px;
  background-color: #f44336;
  color: white;
  margin-bottom: 15px;
  border-radius: 5px;
  opacity: 0.7;
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

.disable {
  pointer-events: none;
  opacity: 0.3
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
