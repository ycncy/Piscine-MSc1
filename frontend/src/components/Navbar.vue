<template>
  <nav class="flex flex-col h-screen justify-around items-center bg-white rounded-r-3xl">
    <div class="">
      <p class="text-3xl">Time Manager</p>
    </div>
    <router-link :to="'/dashboard/workingtimes/' + this.$route.params.userID">Working Times</router-link>
    <router-link :to="'/dashboard/workingtime/' + this.$route.params.userID">Working Time</router-link>
    <router-link :to="'/dashboard/clockmanager/' + this.$route.params.userID">Clock Manager</router-link>
    <router-link :to="'/dashboard/chartmanager/' + this.$route.params.userID">Chart Manager</router-link>
  </nav>
</template>

<script>
export default {
  name: 'Navbar',
};
</script>