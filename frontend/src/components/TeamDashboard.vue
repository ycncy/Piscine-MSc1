<template>
  <div class="grid grid-cols-[1fr_4fr]">
    <User/>
    <DashboardHome v-if="isNaN(parseInt(this.$route.params.userID))" />
    <div v-else class="flex flex-col gap-6 py-6">
      <ul class="flex flex-row justify-around">
        <li>
          <button
              :class="{ 'bg-[#374151] border-none': popupTriggers.trigger_working_times }"
              class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
              @click="togglePopup('trigger_working_times')">
            WorkingTimes
          </button>
        </li>
        <li>
          <button
              :class="{ 'bg-[#374151] border-none': popupTriggers.trigger_charts }"
              class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
              @click="togglePopup('trigger_charts')">
            Charts
          </button>
        </li>
      </ul>
      <WorkingTimes v-if="popupTriggers.trigger_working_times"/>
      <Chart v-if="!popupTriggers.trigger_working_times"/>
    </div>
  </div>
</template>

<script>
import WorkingTimes from "@/components/WorkingTimes.vue";
import {ref} from "vue";
import Chart from "@/components/ChartManager/Chart.vue";
import {authentication_service} from "@/services/authentication.service";
import User from "@/components/User.vue";
import DashboardHome from "@/components/DashboardHome.vue";

export default {
  name: "TeamDashboard",
  components: {DashboardHome, Chart, WorkingTimes, User},
  data() {
    return {
      selected_user: undefined
    }
  },
  created() {
    const authenticated_user = JSON.parse(authentication_service.get_user());

    if (authenticated_user.role === "employee") this.$router.push("/dashboard/profile")
  },
  setup() {
    const popupTriggers = ref({
      trigger_working_times: true,
      trigger_charts: false,
    });

    const togglePopup = (trigger) => {
      for (const key in popupTriggers.value) {
        popupTriggers.value[key] = false;
      }

      popupTriggers.value[trigger] = true;
    };

    return {
      popupTriggers,
      togglePopup
    };
  },
}

</script>