<template>
  <div class="bg-[#2C2C2C]">
    <div class="grid grid-cols-[1fr_5fr]">
      <User />
      <div class="flex flex-col">
        <Navbar/>
        <router-view class="bg-[#232323] h-screen w-full" :key="$route.path"></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import User from "@/components/User.vue";
import Navbar from "@/components/Navbar.vue";

export default {
  components: {
    Navbar,
    User,
  },
};
</script>
