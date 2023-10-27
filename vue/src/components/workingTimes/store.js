import { reactive } from "vue";

export const store = reactive({
  editModal: false,
  deleteModal: false,
  createModal: false,
  workingTimes: [],
  workingTime: {},
  toggleCreateModal() {
    this.createModal = !this.createModal;
  },
  toggleEditModal() {
    this.editModal = !this.editModal;
  },
  toggleDeleteModal() {
    this.deleteModal = !this.deleteModal;
  },
  setWorkingTimes(workingTimes) {
    this.workingTimes = workingTimes;
  },
  workingTimeData(workingTime) {
    // console.log(workingTime.id);
    this.workingTime = workingTime;
  },
});
