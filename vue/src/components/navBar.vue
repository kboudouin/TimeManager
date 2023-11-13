<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useRouter, useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";
import VueCookies from "vue-cookies";
import router from "../router";
import { defineEmits } from "vue";

const emit = defineEmits(["userConnected"]);
const showSideNav = ref(false);
const isAdmin = ref(false);

const checkAdmin = () => {
  isAdmin.value = localStorage.getItem("role") === "admin";
};

const toggleSideNav = () => {
  showSideNav.value = !showSideNav.value;
};

onMounted(checkAdmin);
</script>

<template>
  <!-- MENU -->
  <div class="">
    <label
      style="position: fixed; z-index: 100; top: 18px; left: 10px"
      @click="toggleSideNav"
      class="btn btn-circle swap swap-rotate"
    >
      <input @click="toggleSideNav" type="checkbox" />

      <!-- hamburger icon -->
      <svg
        class="swap-off fill-current"
        xmlns="http://www.w3.org/2000/svg"
        width="32"
        height="32"
        viewBox="0 0 512 512"
      >
        <path
          d="M64,384H448V341.33H64Zm0-106.67H448V234.67H64ZM64,128v42.67H448V128Z"
        />
      </svg>

      <!-- close icon -->
      <svg
        class="swap-on fill-current"
        xmlns="http://www.w3.org/2000/svg"
        width="32"
        height="32"
        viewBox="0 0 512 512"
      >
        <polygon
          points="400 145.49 366.51 112 256 222.51 145.49 112 112 145.49 222.51 256 112 366.51 145.49 400 256 289.49 366.51 400 400 366.51 289.49 256 400 145.49"
        />
      </svg>
    </label>
    <div
      class="flex flex-col flex-auto flex-shrink-0 antialiased bg-gray-50 md:block z-50"
      v-show="showSideNav"
    >
      <div
        class="fixed flex flex-col top-0 left-0 w-72 bg-base-100 h-full border-r border-base-200"
        style="z-index: 90"
      >
        <div class="flex items-center justify-center h-14 ml-14 mt-3">
          <h1 class="flex items-center text-2xl font-extrabold">
            TimeManager<span class="scale-150 mr-2 px-2.5 py-0.50 ml-2"
              >🚀</span
            >
          </h1>
        </div>
        <div class="overflow-y-auto overflow-x-hidden flex-grow">
          <ul class="flex flex-col py-4 space-y-1">
            <li class="px-5">
              <div
                class="flex flex-row items-center h-8 border-t border-base-200"
              >
                <div class="text-sm font-light tracking-wide">Menu</div>
              </div>
            </li>
            <li>
              <a
                @click="Dashboard"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  🖥️
                </span>
                <span class="ml-2 text-sm tracking-wide truncate"
                  >Dashboard</span
                >
              </a>
            </li>
            <li>
              <a
                @click="Charts"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  📊
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Charts</span>
              </a>
            </li>
            <li v-if="isAdmin">
              <a
                @click="Admin"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  🛠
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">
                  Admin Dashboard
                </span>
              </a>
            </li>
            <li>
              <a
                @click="Clock"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-150 justify-center items-center ml-4"
                >
                  ⏱️
                </span>
                <span class="ml-2 text-sm tracking-wide truncate"> Clock</span>
              </a>
            </li>
            <li>
              <a
                @click="workingTimes"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  🕝
                </span>
                <span class="ml-2 text-sm tracking-wide truncate"
                  >Workingtimes</span
                >
              </a>
            </li>
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide">Settings</div>
              </div>
            </li>
            <li>
              <a
                @click="Profile"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  👤
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Profile</span>
              </a>
            </li>
            <li>
              <a
                @click="Teams"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  👥
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Teams</span>
              </a>
            </li>
            <li>
              <a
                @click="Logout"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-150 justify-center items-center ml-4"
                >
                  ↪
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Logout</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
    };
  },
  methods: {
    Logout() {
      this.isUserConnected = false;
      localStorage.removeItem("userId");
      localStorage.removeItem("role");
      const $toast = useToast();
      $toast.success("You are logged out!");
      localStorage.removeItem("userEmail");
      localStorage.removeItem("userUsername");
      this.isUserConnected = false;
      VueCookies.remove("token");
      router.replace("/");
      this.$emit("userConnected");
    },
    Charts() {
      router.push("/ChartManager/" + localStorage.getItem("userId"));
    },
    Clock() {
      router.push("/clock/" + localStorage.getItem("userId"));
    },
    Profile() {
      router.push("/Profile/" + localStorage.getItem("userId"));
    },
    workingTimes() {
      router.push("/working-times/" + localStorage.getItem("userId"));
    },
    Admin() {
      router.push("/admin");
    },
    Teams() {
      router.push("/Teams");
    },
    Dashboard() {
      router.push("/Dashboard");
    },
  },
};
</script>

<style scoped></style>
