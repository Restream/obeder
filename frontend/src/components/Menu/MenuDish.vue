<template>
  <div class="menu-dish">
    <h5 class="menu-dish__header">{{typePresented}}</h5>
    <ul>
      <li v-for="dish in dishes" class="menu-dish__item">
        <div class="voter-container">
          <menu-voter
            :dishId="dish.id"
            :voted="dish.voted"
            :ratingUp="dish.ratingUp"
            :ratingDown="dish.ratingDown"
            @vote="vote" />
        </div>
        <div class="thumbnail-container">
          <div
             v-show="dish.image.url"
             class="thumbnail"
             :style="`background-image: url(${ dish.image.thumb.url });`"
             @click="showImage(dish.image.url, dish.description)" >
          </div>
        </div>
        <label
          class="menu-dish__label"
          :for="date + dish.id"
          :title="dish.description" >
          <input
          type="radio"
          v-model="selectedDish"
          :name="date + type"
          :id="date + dish.id"
          :value="dish.id" >
          <span class="menu-dish__radio" />
          <div>
            <span class="menu-dish__name">{{dish.name}}</span>
            <span class="menu-dish__description" v-if="dish.description">{{dish.description}}</span>
          </div>
        </label>
      </li>
    </ul>
  </div>
</template>

<script>
  import _ from 'lodash';
  import MenuPresenter from '../../presenters/MenuPresenter';
  import MenuVoter from './MenuVoter';

  function getSelectedDishId(dishes) {
    const selectedDish = _.find(dishes, { selected: true });

    return selectedDish && selectedDish.id;
  }

  export default {
    components: {
      'menu-voter': MenuVoter,
    },
    name: 'MenuDish',

    data() {
      return {
        typePresented: MenuPresenter.dishType(this.type),
        selectedDish: getSelectedDishId(this.dishes),
      };
    },

    props: {
      date: String,
      dishes: Array,
      type: String,
      onChange: Function,
    },

    watch: {
      selectedDish(dish) {
        this.onChange(this.type, dish);
      },
      dishes(dishes) {
        this.selectedDish = getSelectedDishId(dishes);
      },
    },

    methods: {
      showImage(url, description) {
        this.$emit('showImage', url, description);
      },
      vote(value, dishId) {
        this.$emit('vote', value, dishId, this.type);
      },
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

.menu-dish__item {
  margin-bottom: 10px;
  display: flex;
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
  align-self: center;
  align-items: center;

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
  padding-top: 1px;
}

.menu-dish__description {
  font-size: 10px;
  display: block;
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

.thumbnail {
  width: 40px;
  height: 40px;
  margin: 2px 15px 0 0;
  cursor: pointer;
  display: inline-block;
  background: no-repeat center center;
  border: 1px solid #CCCCCC;
  background-size: cover;
}

.thumbnail-container {
  display: inline-flex;
  align-self: center;
}

.voter-container {
  width: 60px;
  padding-right: 15px;
  display: inline-flex;
  align-self: center;
}
</style>
