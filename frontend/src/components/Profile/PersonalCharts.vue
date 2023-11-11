<template>
  <div>
    <div class="flex w-[90%] min-h-screen flex-row gap-2 items-center m-auto justify-center py-10">
      <div class="flex w-1/3 flex-col h-full gap-4">
        <div class="bg-[#161717] h-full shadow-lg rounded-3xl flex items-center justify-center p-8">
          <Loader class="flex justify-center" v-if="!percent_working_times"/>
          <Pie v-else :dataset="percent_working_times" :date="percent_label"/>
        </div>
      </div>
      <div class="w-2/3 h-full flex flex-col gap-4">
        <div class="bg-[#161717] h-full shadow-lg rounded-3xl flex items-center justify-center p-8">
          <Loader class="flex justify-center" v-if="!user_working_times"/>
          <Line v-else :dataset="user_working_times" :date="date"/>
        </div>
        <div class="bg-[#161717] h-full shadow-lg rounded-3xl flex items-center justify-center p-8">
          <Loader class="flex justify-center" v-if="!weeklyData"/>
          <Bar v-else :dataset="weeklyData" :date="weeklyLabel"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {working_time_service} from "@/services/workingtimes.service";
import Line from "@/components/ChartManager/Line.vue";
import Bar from "@/components/ChartManager/Bar.vue";
import Pie from "@/components/ChartManager/Pie.vue";
import Radar from "@/components/ChartManager/Radar.vue";
import {authentication_service} from "@/services/authentication.service";
import Loader from "@/components/Loader.vue";

export default {
  name: 'PersonalChart',
  data() {
    return {
      user_working_times: undefined,
      percent_working_times: undefined,
      date: [],
      percent_label: [],
      weeklyData: undefined,
      weeklyLabel: ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"],
      selectedChart: 'line'
    }
  },
  components: {Loader, Line, Bar, Pie, Radar},
  created() {
    if (!authentication_service.is_logged()) this.$router.push("/");
  },
  async mounted() {
    if (!authentication_service.is_logged()) {
      this.$router.push("/");
    } else {
      const user_id = JSON.parse(authentication_service.get_user()).id;

      let data = await working_time_service.get_working_times_by_id(user_id);
      let stackedTime= [0,0,0,0,0,0,0];
      let time = [];

      let today = new Date();

    // Get the first day of the current week (Sunday)
    let startOfWeek = new Date(today);
    startOfWeek.setDate(today.getDate() - today.getDay());

    // Get the first day of the next week (Sunday)
    let endOfWeek = new Date(startOfWeek);
    endOfWeek.setDate(startOfWeek.getDate() + 7);

      const minimum_time = 8
      let overtime = 0, normaltime = 0, undertime = 0
      for (let index = 0; index < data.data.length; index++) {
        let start = new Date(data.data[index].start_time);
        let end = new Date(data.data[index].end_time);
        time.push((end.getTime() - start.getTime()) / (1000 * 60 * 60));
        this.date.push(start.getDate() + "-" + start.getMonth());
        if(start >= startOfWeek && start<= endOfWeek){
          stackedTime[start.getDay()-1]+=time[index]
        }
        if (time[index] > minimum_time) {

          overtime += time[index] - minimum_time;
          normaltime += minimum_time
        } else if (time[index] < minimum_time) {

          normaltime += time[index];
          undertime += minimum_time - time[index];
        }
        else {
          this.$router.push("/")
        }
      }
      this.weeklyData = [
        {
          label: "Time",
          data: stackedTime,
          borderColor: '#3B82F6',
          backgroundColor: '#3B82F6'
        }
      ]
      this.user_working_times = [
        {
          label: "Time",
          data: time,
          borderColor: '#3B82F6',
          backgroundColor: '#3B82F6'
        }
      ];
      this.percent_working_times = [
        {
          data: [normaltime, overtime, undertime],
          borderColor: ['#3CB371', '#3B82F6', '#FF4500'],
          backgroundColor: ['#3CB371', '#3B82F6', '#FF4500']
        }
      ]
      this.percent_label = ['normal time', 'overtime', 'undertime']

    }
  },
  methods: {
    showChart(chartType) {
      this.selectedChart = chartType;
    }
  }
}
</script>
