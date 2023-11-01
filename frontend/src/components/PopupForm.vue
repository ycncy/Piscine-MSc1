<template>
  <div id="popup">
    <div id="innerPopup" class="bg-white shadow p-4 py-6 sm:p-6 sm:rounded-lg">
      <slot />
      <button class="w-full px-4 py-2 text-red-600 font-medium rounded-lg" id="close" @click="togglePopup()">
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
    background: rgb(0, 0, 0, 0.3);
    display: flex;
    align-items: center;
    justify-content: center;
  }
</style>