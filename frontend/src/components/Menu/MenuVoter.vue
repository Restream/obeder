<template>
  <div class="vote-block">
    <div class="vote vote-up"
         v-bind:class="{'vote-up--active': voted}"
         @click="voteChanged(true)">
      <div class="inner"></div>
    </div>
    <div class="caption">
      <span class="text-success">{{ratingUp}}</span>&nbsp;/&nbsp;<span class="text-danger">{{ratingDown}}</span>
    </div>
    <div class="vote vote-down"
         v-bind:class="{'vote-down--active': voted === false}"
         @click="voteChanged(false)">
      <div class="inner"></div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'MenuVoter',
    props: {
      ratingUp: Number,
      ratingDown: Number,
      dishId: Number,
      voted: {
        type: Boolean,
        required: false,
      },
      vote: Function,
    },
    methods: {
      voteChanged(value) {
        if (value !== this.voted) this.$emit('vote', value, this.dishId);
      },
    },
  };
</script>
<style scoped>
  @import "../../assets/styles/voter-theme.css";

  .vote-block {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .vote, .inner {
    width: 0;
    height: 0;
    border: solid transparent;
    cursor: pointer;
  }

  .vote {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .caption {
    color: #9b9999;
    margin: 5px 0;
    font-size: 14pt;
  }

  .vote-up {
    border-width: 0 10px 10px 10px;
    border-bottom-color: var(--unvotedColorBorder);

    & .inner {
      transform: translate(0%, 66%);
      border-width: 0 8px 8px 8px;
      border-bottom-color: var(--unvotedColor);
    }

    & .inner:hover, &--active .inner {
      border-bottom-color: var(--votedUpColor);
    }

    &:hover, &--active {
      border-bottom-color: var(--votedUpColorBorder);
    }
  }

  .vote-down {
    border-width: 10px 10px 0 10px;
    border-top-color: var(--unvotedColorBorder);

    & .inner {
      transform: translate(0%, -66%);
      border-width: 8px 8px 0 8px;
      border-top-color: var(--unvotedColor);
    }

    & .inner:hover, &--active .inner {
      border-top-color: var(--votedDownColor);
    }

    &:hover, &--active {
      border-top-color: var(--votedDownColorBorder);
    }
  }

  .text-success {
    color: var(--textSuccess);
  }

  .text-danger {
    color: var(--textDanger);
  }
</style>
