<template>
  <div id="popup">
    <div id="innerPopup" class="bg-white p-6 rounded-3xl flex flex-col gap-4 text-gray-500 w-1/3" >
      <slot />
      <button class="rounded-lg text-white p-2 bg-red-500" id="close" @click="togglePopup()">
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