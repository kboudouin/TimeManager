import { createRouter, createWebHistory } from "vue-router";
import ChartManager from "./components/ChartManager.vue";
import Admin from "./components/admin/Admin.vue";
import Clock from "./components/Clock.vue";
import Profile from "./components/Profile.vue";
import Teams from "./components/Teams.vue";
import error from "./components/notAuthorised.vue";
import wtRender from "./components/workingTimes/wtRender.vue";
import Landing from "./components/Landing.vue";

const routes = [
  { path: "/", name: "landing", component: Landing },
  { path: "/error", name: "error", component: error },
  { path: "/Admin", name: "Admin", component: Admin },
  { path: "/Dashboard/:id", name: "chartManager", component: ChartManager },
  { path: "/Clock/:id", name: "clock", component: Clock },
  { path: "/Profile/:id", name: "profile", component: Profile },
  { path: "/working-times/:id", name: "workingtime", component: wtRender },
  { path: "/Teams/:id", name: "Teams", component: Teams },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  console.log("Navigating from:", from.fullPath, "to:", to.fullPath);
  next();
});

export default router;
