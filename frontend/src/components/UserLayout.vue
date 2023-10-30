<template>
  <div class="bg-gray-100 grid grid-rows-[1fr_5fr] h-screen">
    <User />
    <router-view class="bg-gray-100 font-sans"></router-view>
  </div>
</template>

<script>
import User from "@/components/User.vue";

export default {
  components: {
    User,
  },
};
</script>
