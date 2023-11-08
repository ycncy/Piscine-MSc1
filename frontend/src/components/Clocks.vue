<template>
  <div>
    <button :class="{ green: isActive, red: !isActive }" class="rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="toggle">
      {{ isActive ? 'ON' : 'OFF' }}
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
      // isActive: false,
      clocks: [],
      current_user: undefined
    };
  },
  methods: {
    async toggle() {
      this.isActive = this.isActive ? false : true;
      localStorage.setItem('isActive', this.isActive);
      const check_clock = await clocks_service.check_clock(JSON.parse(authentication_service.get_user()).id, this.isActive, new Date());

      if (check_clock.status_code === 200) window.location.reload();

    },
    async getClock_status() {
      const response = await clocks_service.get_clock_by_user_id(
          JSON.parse(authentication_service.get_user()).id
      );
      console.log(response)
      const status = response.data[0].status
      console.log(status)
      this.isActive = status
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
      console.log("refresh")
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
  background-color: green; /* Change to your desired "on" color */
  color: white;
}

.red {
  background-color: red; /* Change to your desired "off" color */
  color: white;
}
</style>
