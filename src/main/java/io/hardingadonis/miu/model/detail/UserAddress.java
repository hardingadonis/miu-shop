package io.hardingadonis.miu.model.detail;

public class UserAddress {

    private String province;
    private String district;
    private String ward;
    private String specific;

    public UserAddress() {
    }

    public UserAddress(String province, String district, String ward, String specific) {
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.specific = specific;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getSpecific() {
        return specific;
    }

    public void setSpecific(String specific) {
        this.specific = specific;
    }

    @Override
    public String toString() {
        return specific + ", " + ward + ", " + district + ", " + province;
    }
}
