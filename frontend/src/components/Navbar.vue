<template>
  <nav class="navbar">
    <router-link :to="'/workingtimes/' + this.$route.params.userID">Working Times</router-link>
    <router-link :to="'/workingtime/' + this.$route.params.userID">Working Time</router-link>
    <router-link :to="'/clockmanager/' + this.$route.params.userID">Clock Manager</router-link>
    <router-link :to="'/chartmanager/' + this.$route.params.userID">Chart Manager</router-link>
  </nav>
</template>

<script>
export default {
  name: 'Navbar',
};
</script>

<style>
.navbar {
  background-color: #333;
  color: #fff;
  display: flex;
  justify-content: space-around;
  padding: 10px 0;
}
</style>