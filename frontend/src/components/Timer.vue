<template>
  <div class="  h-screen flex flex-col justify-center items-center sm:hidden">
        <Clocks/>
    </div>
  </template>

<script>
import Clocks from "@/components/Clocks.vue";
export default {
    name: 'Timer',
    components: {
        Clocks
    }
}
</script>