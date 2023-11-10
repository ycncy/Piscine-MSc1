<template>
  <div>
    <button :class="{ green: isActive, red: !isActive }" class="flex gap-6 items-center p-2 text-gray-900 rounded-full dark:text-white group" @click="toggle">
      <svg class="fill-white h-6 w-6" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><path d="M176 0c-17.7 0-32 14.3-32 32s14.3 32 32 32h16V98.4C92.3 113.8 16 200 16 304c0 114.9 93.1 208 208 208s208-93.1 208-208c0-41.8-12.3-80.7-33.5-113.2l24.1-24.1c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L355.7 143c-28.1-23-62.2-38.8-99.7-44.6V64h16c17.7 0 32-14.3 32-32s-14.3-32-32-32H224 176zm72 192V320c0 13.3-10.7 24-24 24s-24-10.7-24-24V192c0-13.3 10.7-24 24-24s24 10.7 24 24z"/></svg>
    </button>
  </div>

</template>

<script>
import {clocks_service} from "@/services/clocks.service";
import {authentication_service} from "@/services/authentication.service";

export default {
  name: "Clocks",
  data() {
    return {
      isActive: localStorage.getItem('isActive') === 'true' || false,
      clocks: [],
      current_user: undefined
    };
  },
  methods: {
    async toggle() {
      this.isActive = !this.isActive;
      localStorage.setItem('isActive', this.isActive);
      const check_clock = await clocks_service.check_clock(JSON.parse(authentication_service.get_user()).id, this.isActive, new Date());

      if (check_clock.status_code === 200) window.location.reload();

    },
    async getClock_status() {
      const response = await clocks_service.get_clock_by_user_id(
          JSON.parse(authentication_service.get_user()).id
      );
      this.isActive = response.data[0] ? response.data[0].status : false;
    },

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
      this.$router.push({name: "Clocks"});
    },
  },
  created() {
    this.getClock_status();
  },
  mounted() {
    this.getClock_status();
  }
}
</script>
<style>

.ui {
  width: 100px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f5f5f5;
  border: 1px solid #ccc;
  border-radius: 10px;
  text-align: center;
}

.green {
  background-color: green;
  color: white;
}

.red {
  background-color: red;
  color: white;
}
</style>
