<template>
  <div class="menu-dish">
    <h5 class="menu-dish__header">{{typePresented}}</h5>
    <ul>
      <li v-for="dish in dishes">
        <label
          class="menu-dish__label"
          :for="date + dish.id"
          :title="dish.description"
        >
          <input
            type="radio"
            v-model="selectedDish"
            :name="date + type"
            :id="date + dish.id"
            :value="dish.id"
          >
          <span class="menu-dish__radio" />
          <span class="menu-dish__name">{{dish.name}}</span>
        </label>
        <a href="#" v-if="dish.description.length > 0" v-hint.right.rounded="dish.description">
          <icon name="question-circle-o"></icon>
        </a>
      </li>
    </ul>
  </div>
</template>

<script>
  import _ from 'lodash';
  import 'vue-awesome/icons/question-circle-o';
  import Hint from 'vue-hint.css';
  import 'hint.css';
  import Icon from 'vue-awesome/components/Icon';
  import MenuPresenter from '../../presenters/MenuPresenter';

  function getSelectedDishId(dishes) {
    const selectedDish = _.find(dishes, { selected: true });

    return selectedDish && selectedDish.id;
  }

  export default {
    name: 'MenuDish',
    props: {
      date: String,
      dishes: Array,
      type: String,
      onChange: Function,
    },
    components: {
      Icon,
    },
    directives: {
      Hint,
    },
    watch: {
      selectedDish(dish) {
        this.onChange(this.type, dish);
      },
      dishes(dishes) {
        this.selectedDish = getSelectedDishId(dishes);
      },
    },

    data() {
      return {
        typePresented: MenuPresenter.dishType(this.type),
        selectedDish: getSelectedDishId(this.dishes),
      };
    },
  };
</script>

<style scoped>
@import "../../assets/styles/variables.css";
@import "hint.css/hint.min.css";

.menu-dish {
  width: 100%;
  margin-bottom: 15px;
  background: #FAFAFA;
  box-shadow: 0 0 2px 0 rgba(0,0,0,0.12), 0 2px 2px 0 rgba(0,0,0,0.24);
  border-radius: 3px;
  padding: 16px 13px;
}

.menu-dish__header {
  margin-bottom: 12px;
  font-weight: 500;
  font-size: 18px;
  color: #000000;
  letter-spacing: 0.01px;
}

.menu-dish__label {
  cursor: pointer;
  display: inline-flex;
  margin-bottom: 10px;

  & input {
    display: none;
  }

  & input:checked {
    & + .menu-dish__radio {
      border: 2px solid #38B5C7;

      &::after {
        background-color: #38B5C7;
        transform: translate(-50%, -50%) scale(10);
        opacity: 1;
      }
    }
  }
}

.menu-dish__underscored {
    border-bottom-style: dashed;
    border-bottom-width: 1px;
    border-bottom-color: #625f66;
}

.menu-dish__radio {
  flex: 0 0 20px;
  width: 20px;
  height: 20px;
  border: 2px solid rgba(0, 0, 0, 0.5);
  border-radius: 50%;
  margin-right: 10px;
  transition: border-color 150ms ease-in-out;
  position: relative;

  &::after {
    content: '';
    width: 1px;
    height: 1px;
    border-radius: 50%;
    opacity: 0;
    background-color: rgba(0, 0, 0, 0.5);
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%) scale(1);
    transition: opacity, transform 150ms ease-in-out;
  }
}

.menu-dish__name {
  font-size: 16px;
  color: #000000;
  letter-spacing: 0.01px;
  padding-top: 3px;
}

@media (--desktop) {
  .menu-dish {
    margin-bottom: 28px;
    width: calc(50% - 14px);
    padding: 14px 25px;
  }

  .menu-dish__header {
    font-size: 20px;
  }
}
</style>
