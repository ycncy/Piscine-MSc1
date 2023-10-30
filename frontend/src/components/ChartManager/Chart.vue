<template>
  <p class="text-center text-4xl py-4">ChartManager</p>
  <div class="grid grid-cols-2 h-4/5 m-auto place-items-center">
    <div class="bg-gray-100 p-8 rounded">
      <Line :dataset="this.user_working_times" :date="this.date"/>
    </div>
    <div class="bg-gray-100 p-8 rounded">
      <Bar :dataset="this.user_working_times" :date="this.date"/>
    </div>
    <div class="bg-gray-100 p-8 rounded">
      <Pie :dataset="this.user_working_times" :date="this.date"/>
    </div>
    <div class="bg-gray-100 p-8 rounded">
      <Radar :dataset="this.user_working_times" :date="this.date"/>
    </div>
  </div>
</template>

<script>
import {get_working_times_by_id} from "@/services/workingtimes.service";
import Line from "@/components/ChartManager/Line.vue";
import Bar from "@/components/ChartManager/Bar.vue";
import Pie from "@/components/ChartManager/Pie.vue";
import Radar from "@/components/ChartManager/Radar.vue";

export default {
  name: 'chart',
  data() {
    return {
      user_working_times: [],
      date: []
    }
  },
  components: {Line, Bar, Pie, Radar},
  async mounted() {
    let data = await get_working_times_by_id(this.$route.params.userID);
    let time = []

    for (let index = 0; index < data.data.length; index++) {
      let start = new Date(data.data[index].start_time)
      let end = new Date(data.data[index].end_time)
      time.push(((end.getTime()) - (start.getTime())) / (1000 * 60 * 60))
      this.date.push(start.getDate() + "-" + start.getMonth());
    }
    this.user_working_times = [{
      label: "Time",
      data: time,
      borderColor: 'lightBlue',
      backgroundColor: 'lightBlue'
    }]
  }
}
</script>