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
</script>

<template>
  <!-- SIGN IN-->
  <div>
    <div
      class="p-12 bg-base-300 mx-auto rounded-2xl md:w-fit sm:w-full"
      id="SignInDiv"
      v-if="SignInDiv"
    >
      <div class="mb-4">
        <h3 class="font-semibold text-2xl text-white">Sign In</h3>
        <p class="text-gray-500">Please sign in to your account.</p>
      </div>
      <div class="space-y-5">
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >Email</label
          >
          <input
            v-model="email"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="email"
            placeholder="Enter your email"
          />
        </div>
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >password</label
          >
          <input
            v-model="password"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="password"
            placeholder="Enter your password"
          />
        </div>

        <div>
          <button
            @click="API"
            type="submit"
            class="w-full flex justify-center bg-green-400 hover:bg-green-500 text-gray-100 p-3 rounded-full tracking-wide font-semibold shadow-lg cursor-pointer transition ease-in duration-500"
          >
            <div>SIGN IN</div>

            <div v-if="loading" role="status" class="ml-10">
              <svg
                aria-hidden="true"
                class="w-6 h-6 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
                viewBox="0 0 100 101"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                  fill="currentColor"
                />
                <path
                  d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                  fill="currentFill"
                />
              </svg>
              <span class="sr-only">Loading...</span>
            </div>
          </button>
        </div>
      </div>

      <div class="pt-5 text-center text-gray-400 text-xs">
        <span>
          <button
            class="text-green hover:text-green-500"
            @click="CreateAccountButton"
          >
            CREATE NEW ACCOUNT
          </button>
        </span>
      </div>
    </div>

    <!-- CREATE ACC-->
    <div
      class="p-12 bg-base-300 mx-auto rounded-2xl md:w-fit sm:w-full"
      id="CreateAccountDiv"
      v-show="showCreateAccount"
    >
      <div class="mb-4">
        <h3 class="font-semibold text-2xl text-white">Get Registred</h3>
        <p class="text-gray-500">Create a new user account</p>
      </div>
      <div class="space-y-5">
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >Username</label
          >
          <input
            v-model="username"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type=""
            placeholder="Enter your username"
          />
        </div>
        <div class="space-y-2">
          <label class="mb-5 text-sm font-medium text-white tracking-wide">
            Email
          </label>
          <input
            v-model="email"
            class="w-full content-center text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="email"
            placeholder="Enter your email"
          />
        </div>
        <div class="space-y-2">
          <label class="mb-5 text-sm font-medium text-white tracking-wide">
            Password
          </label>
          <input
            v-model="password"
            class="w-full content-center text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type="password"
            placeholder="Enter your password"
          />
        </div>
        <div class="flex items-center justify-between"></div>
        <div>
          <button
            @click="CreateUSER"
            type="submit"
            class="w-full flex justify-center bg-green-400 hover:bg-green-500 text-gray-100 p-3 rounded-full tracking-wide font-semibold shadow-lg cursor-pointer transition ease-in duration-500"
          >
            CREATE ACCOUNT
          </button>
        </div>
      </div>

      <div class="pt-5 text-center text-gray-400 text-xs">
        <span>
          <button class="text-green hover:text-green-500" @click="Backtologin">
            ALREADY HAVE AN ACCOUNT ? LOG IN HERE
          </button>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      SignInDiv: true,
      showCreateAccount: false,
      username: "",
      email: "",
      loading: false,
    };
  },
  methods: {
    CreateAccountButton() {
      this.SignInDiv = false;
      this.showCreateAccount = !this.showCreateAccount;
    },
    Backtologin() {
      this.SignInDiv = true;
      this.showCreateAccount = false;
    },
    async API() {
      this.loading = true;
      const email = this.email;
      const pass = this.password;

      try {
        const response = await axios.post(
          `http://44.207.191.254:4000/api/login?email=${email}&password=${pass}`,
          {},
          { withCredentials: true }
        );

        if (response.data.user) {
          localStorage.setItem("role", response.data.user.role);
          localStorage.setItem("userId", response.data.user.id);
          localStorage.setItem("userUsername", response.data.user.username);
          localStorage.setItem("userEmail", response.data.user.email);
          router.push("/dashboard/" + response.data.user.id);
          this.$emit("userConnected");
          const $toast = useToast();
          $toast.success("Logged in!");
          this.loading = false;
        }
      } catch (error) {
        console.error("API request failed:", error);
        const $toast = useToast();
        $toast.error("Something went wrong!");
        this.loading = false;
      }
    },
    // Méthode pour créer un utilisateur (POST)
    CreateUSER() {
      const username = this.username;
      const email = this.email;
      const password = this.password;
      axios
        .post(
          `http://44.207.191.254:4000/api/users?email=${email}&username=${username}&password=${password}&role=employee`
        )
        .then((response) => {
          const $toast = useToast();
          $toast.success("Account created! Please login!");
          this.SignInDiv = true;
          this.showCreateAccount = false;
          console.log(response.data);
        })
        .catch((error) => {
          console.error("API request failed: USER FAILED TO BE ADDED", error);
        });
    },
  },
};
</script>

<style scoped></style>
