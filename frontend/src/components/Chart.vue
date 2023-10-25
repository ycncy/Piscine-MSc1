<template>
  <Line
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />
</template>

<script>
let variable = [10,20,30,40]
let variable2 = [30,20,20,60]
let dataone = [{label:"data one",data:variable},{label:"data two",data:variable2}]
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
        labels: [ 'January', 'February', 'March' , 'april','may' ],
        datasets: dataone
      },
      chartOptions: {
        responsive: true
      }
    }
  }
}
</script>