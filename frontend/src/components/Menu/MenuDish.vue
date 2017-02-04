<template>
  <div class="menu-dish">
    <h5 class="menu-dish__header">{{typePresented}}</h5>
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
  import MenuPresenter from '../../presenters/MenuPresenter';

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
        typePresented: MenuPresenter.dishType(this.type),
        radioIdentifier: this.date + this.type,
        selectedDish: getSelectedDishId(this.dishes),
      };
    },
  };
</script>

<style scoped>
@import "../../assets/styles/variables.css";

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
