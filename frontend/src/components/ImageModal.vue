<template>
  <div v-show="largeImage" @close="hideLargeImage" @click="hideLargeImage" transition="modal">
    <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-body">
            <slot name="body">
              <img class="center" :src="image.url"/>
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
              {{ this.image.description }}
            </slot>
          </div>
        </div>
      </div>
    </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: 'ImageModal',
  data() {
    return {
      largeImage: this.show,
    };
  },
  props: {
    image: Object,
    show: {
      type: Boolean,
      default: false,
    },
  },
  watch: {
    show(isShow) {
      if (isShow) {
        this.showLargeImage();
      }
    },
  },
  methods: {
    escListener(e) {
      const escKey = 27;
      if (e.keyCode === escKey) {
        this.hideLargeImage();
      }
    },
    showLargeImage() {
      this.largeImage = true;
      document.addEventListener('keydown', this.escListener);
    },
    hideLargeImage() {
      this.largeImage = false;
      document.removeEventListener('keydown', this.escListener);
      this.$emit('close');
    },
  },
};
</script>

<style scoped>
.modal-mask {
	position: fixed;
	z-index: 9998;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, .5);
	display: table;
	transition: opacity .3s ease;
}

.modal-wrapper {
	display: table-cell;
	vertical-align: middle;
}

.modal-container {
	width: 610px;
	margin: 0px auto;
	padding: 20px 30px;
	background-color: #fff;
	border-radius: 2px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
	transition: all .3s ease;
	font-family: Helvetica, Arial, sans-serif;
}

.modal-body {
	margin: 20px 0;
}

.modal-enter {
	opacity: 0;
}

.modal-leave-active {
	opacity: 0;
}

</style>
