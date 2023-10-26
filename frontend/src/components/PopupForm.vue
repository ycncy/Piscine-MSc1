<template>
  <div id="popup">
    <div id="innerPopup">
      <slot />
      <button id="close" @click="togglePopup()">
        Cancel
      </button>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['togglePopup']
  }
</script>

<style scoped>
  #popup {
    position: fixed;
    top: 0;
    right: 0;
    left: 0;
    bottom: 0;
    z-index: 99;
    background: rgb(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;

    #innerPopup {
      background: white;
      padding: 4%;
    }
  }
</style>