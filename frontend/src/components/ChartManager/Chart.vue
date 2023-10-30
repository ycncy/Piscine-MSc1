  <template>
    <div class="p-4 m-auto gap-4 justify-center items-center h-full w-[90%]">
      <div class="p-8 rounded-3xl flex flex-col gap-16 shadow-md h-full bg-white border border-blue">
        <div class="flex flex-row justify-around">
          <button @click="showChart('line')">Line Chart</button>
          <button @click="showChart('bar')">Bar Chart</button>
          <button @click="showChart('pie')">Pie Chart</button>
          <button @click="showChart('radar')">Radar Chart</button>
        </div>
        <div v-if="selectedChart === 'line'">
          <Line :dataset="user_working_times" :date="date"/>
        </div>
        <div v-else-if="selectedChart === 'bar'">
          <Bar :dataset="user_working_times" :date="date"/>
        </div>
        <div v-else-if="selectedChart === 'pie'" class="w-[50%] m-auto">
          <Pie :dataset="user_working_times" :date="date"/>
        </div>
        <div v-else-if="selectedChart === 'radar'" class="w-[50%] m-auto">
          <Radar :dataset="user_working_times" :date="date"/>
        </div>
      </div>
    </div>
  </template>

  <script>
  import { get_working_times_by_id } from "@/services/workingtimes.service";
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
    components: { Line, Bar, Pie, Radar },
    async mounted() {
      let data = await get_working_times_by_id(this.$route.params.userID);
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
