<template>
  <Line
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />
</template>

<script>
import { get_working_times_by_id, get_all_working_times } from "@/services/workingtimes.service";


      let data =await get_all_working_times();
console.log(data.data[0])
let time = []

let date = []
for (let index = 0; index < data.data.length; index++) {
  let start=new Date(data.data[index].start_time)
  let end =new Date(data.data[index].end_time)
  time.push( ( (end.getTime() ) - ( start.getTime() ) ) / (1000 * 60 * 60) ) 
  console.log(time)
  date.push( start.getDate()+"-"+ start.getMonth());
}
let dataset = [{label:"Time",data:time}]
import { Line } from 'vue-chartjs'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
)

export default {
  name: 'LinrChart',
  components: { Line },
  data() {
    return {
      chartData: {
        labels: date,
        datasets: dataset
      },
      chartOptions: {
        responsive: true,
        plugins: {
          title: {
            display: true,
            text: 'Working times chart'
          },
        }
      }
    }
  }
}
</script>