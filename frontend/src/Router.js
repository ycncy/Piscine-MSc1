import {createRouter, createWebHistory} from "vue-router";
import WorkingTimes from "@/components/WorkingTimes.vue";
import Chart from "@/components/ChartManager/Chart.vue";
import Clocks from "@/components/Clocks.vue";
import User from "@/components/User.vue";

const routes = [
    { path: "/:userID", component: User, name: "User" },
    { path: '/workingTimes/:userID', component: WorkingTimes, name: "WorkingTimes" },
    { path: '/workingTime/:userID', component: WorkingTimes, name: "WorkingTime" },
    { path: '/clockManager/:userID', component: Clocks, name: "ClockManager" },
    { path: '/chartManager/:userID', component: Chart, name: "ChartManager" },
];
const Router = createRouter({
    history: createWebHistory("/dashboard"),
    routes
});

export default Router;