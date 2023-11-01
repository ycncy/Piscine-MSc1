<template>
    <div class="flex flex-row gap-4 items-center justify-center py-10">
      <div class="flex w-1/3 flex-col h-full gap-4">
        <div class="bg-[#161717] h-full shadow-lg rounded-3xl flex items-center justify-center p-8"><Pie :dataset="user_working_times" :date="date"/></div>
        <div class="bg-[#161717] h-full shadow-lg rounded-3xl flex items-center justify-center p-8"><Radar :dataset="user_working_times" :date="date"/></div>
      </div>
      <div class="w-1/2 h-full flex flex-col gap-4">
        <div class="bg-[#161717] h-full shadow-lg rounded-3xl flex items-center justify-center p-8"><Line :dataset="user_working_times" :date="date"/></div>
        <div class="bg-[#161717] h-full shadow-lg rounded-3xl flex items-center justify-center p-8"><Bar :dataset="user_working_times" :date="date"/></div>
      </div>
    </div>
</template>

<script>
import {working_time_service} from "@/services/workingtimes.service";
import Line from "@/components/ChartManager/Line.vue";
import Bar from "@/components/ChartManager/Bar.vue";
import Pie from "@/components/ChartManager/Pie.vue";
import Radar from "@/components/ChartManager/Radar.vue";

export default {
  name: 'chart',
  data() {
    return {
      user_working_times: [],
      date: [],
      selectedChart: 'line'
    }
  },
  components: {Line, Bar, Pie, Radar},
  async mounted() {
    let data = await working_time_service.get_working_times_by_id(this.$route.params.userID);
    let time = [];

    for (let index = 0; index < data.data.length; index++) {
      let start = new Date(data.data[index].start_time);
      let end = new Date(data.data[index].end_time);
      time.push((end.getTime() - start.getTime()) / (1000 * 60 * 60));
      this.date.push(start.getDate() + "-" + start.getMonth());
    }
    this.user_working_times = [
      {
        label: "Time",
        data: time,
        borderColor: '#3B82F6',
        backgroundColor: '#3B82F6'
      }
    ];
  },
  methods: {
    showChart(chartType) {
      this.selectedChart = chartType;
    }
  }
}
</script>
