<template>
  <Radar
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />
</template>

<script>
import {inject} from 'vue'
import { Radar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  RadialLinearScale,
  PointElement,
  LineElement,
  Filler,
  Tooltip,
  Legend
} from 'chart.js'

ChartJS.register(
  RadialLinearScale,
  PointElement,
  LineElement,
  Filler,
  Tooltip,
  Legend
)

export default {
  name: 'LinrChart',
  components: { Radar },
  data() {
    return {
      chartData: {
        labels: inject('date'),
        datasets: inject('datasets')
      },
      chartOptions: {
        responsive: true
      }
    }
  }
}
</script>