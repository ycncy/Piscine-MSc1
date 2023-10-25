<script >
    export default {
      methods: {
        startDateTimer() {
          this.timer = setInterval(() => {
            this.date = new Date();
          }, 1000);
        },
        clockIn() {
          this.startDateTimer();
        },
        refresh() {
          this.date = new Date();
        },
        clocks() {
          this.$router.push({ name: "Clocks" });
        },
        }
    }
</script>

<template>
  <button @click="count++">You clicked me {{ count }} times.</button>
</template>